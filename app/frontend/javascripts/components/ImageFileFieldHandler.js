class ImageFileFieldHandler {
  constructor(imageFileField) {
    this.imageFileField = imageFileField;
    this.fileInput = this.imageFileField.querySelector('.c-form__field-input');
    this.imageSelector = this.imageFileField.querySelector('.c-form__field-image-selector');
    this.imageSelectorLabel = this.imageSelector.querySelector('.c-form__field-image-selector-label');
    this.imagePreviewElement = this.imageSelector.querySelector('.c-form__field-image-preview');

    this.handleUpload();
  }

  handleUpload = () => {
    this.fileInput.addEventListener('change', (e) => {
      const imageData = e.target.files[0];
      const imageUrl = window.URL.createObjectURL(imageData);


      this.imagePreviewElement.src = imageUrl
    });
  }
}

export default ImageFileFieldHandler;