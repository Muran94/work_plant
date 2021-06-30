module TimeHelper
  TIME_UNITS     = { hour: "時間", minute: "分", second: "秒" }
  HOUR_SECONDS   = 3_600
  MINUTE_SECONDS = 60

  # 5420 -> 01時間30分
  def format_seconds_to_hour_min(seconds)
    time_values = _set_time_values(%i[hour minute], seconds)
    time_values.inject("") { |string, (key, value)| string += sprintf("%02d", value) + TIME_UNITS[key] }
  end

  # 5420 -> 01時間30分20秒
  def format_seconds_to_hour_min_sec(seconds)
    time_values = _set_time_values(%i[hour minute second], seconds)
    time_values.inject("") { |string, (key, value)| string += sprintf("%02d", value) + TIME_UNITS[key] }
  end

  private

  # 「5420 -> 1時間30分20秒」の「1」の値を求める。
  def _calc_hour_value(seconds)
    seconds / HOUR_SECONDS
  end

  # 「5420 -> 1時間30分20秒」の「30」の値を求める。
  def _calc_minute_value(seconds)
    seconds % HOUR_SECONDS / MINUTE_SECONDS
  end

  # 「5420 -> 1時間30分20秒」の「20」の値を求める。
  def _calc_second_value(seconds)
    seconds % HOUR_SECONDS % MINUTE_SECONDS
  end

  # 時間、分、秒のそれぞれの値を求め、ハッシュ値として返す。
  # ==== 引数
  # * +time_units+ - :hour, :minute, :secondの内、必要な値を含めた配列を渡す。
  # * +seconds+ - 指定のフォーマットの時間を求めるために必要となる、元の秒数。
  # ==== 戻り値
  # 例 _set_time_values(%i[hour minute], 5_400) => { hour: 1, minute: 30 }
  # 例 _set_time_values(%i[hour minute second], 5_430) => { hour: 1, minute: 30, second: 30 }
  def _set_time_values(times_units, seconds)
    time_values = {}
    times_units.each { |key| time_values[key] = send("_calc_#{key}_value", seconds) }
    time_values
  end
end
