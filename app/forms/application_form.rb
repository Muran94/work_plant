class ApplicationForm
  class PrimaryModelNotDefined < StandardError; end



  ### Constants



  ### Modules
  include ::ActiveModel::Model
  include ::ActiveModel::Validations::Callbacks
  include ::ActiveRecord::Transactions

  define_model_callbacks :save



  ### Callbacks



  ### Delegations
  delegate :transaction, to: ::ActiveRecord::Base



  ### Validations
  validate :_validate_models



  ### Class Methods
  class << self
    attr_accessor :model_names

    def model_names
      @model_names ||= []
    end
  end



  ### Getters, Setters
  attr_reader :models, :primary_model


  ### Instance Methods

  def initialize(attributes = {})
    _define_attr_accessors

    super(attributes)
    initialize_models
    initialize_attributes
  end

  def initialize_attributes
    self.class.model_names.each do |model_name|
      model            = _model(model_name)
      model_attributes = _model_attributes(model_name)

      model.assign_attributes(model_attributes)
    end
  end

  def initialize_models
    @models = []
  end
  
  def persisted?
    primary_model.persisted?
  end
  
  def primary_model
    models.first || raise(PrimaryModelNotDefined, "`primary_model` method must return some model object.")
  end

  def save(options: {})
    _save_form(options)

  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActiveModel::ValidationError
    false
  end

  def save!(options: {})
    _save_form(options)
  end



  private

  def _define_attr_accessors
    model_names = self.class.model_names

    class_eval do
      attr_accessor *model_names.map(&:to_sym)
      attr_accessor *model_names.map { |model_name| "#{model_name}_attributes" }
    end
  end

  def _model(model_name)
    self.send(model_name.to_sym)
  end

  def _model_attributes(model_name)
    self.send("#{model_name.to_sym}_attributes") || {}
  end

  def _save_form(options)
    validate! unless options[:validate] == false

    run_callbacks :commit do
      _save_in_transaction(options)
    end

    true
  end

  def _save_in_transaction(options)
    transaction do
      run_callbacks :save do
        _save_models(options)
      end
    end
  rescue Exception => e
    _handle_transaction_rollback(e)
  end

  def _save_models(options)
    options.merge!(validate: false)

    models.map { |model| model.save!(**options) }
  end

  def _validate_models
    models.each { |model| _promote_errors(model) if model.invalid? }
  end

  def _promote_errors(model)
    errors.merge!(model.errors)
  end

  def _handle_transaction_rollback(exception)
    run_callbacks :rollback
    raise exception
  end
end