module LeavesHelper

  def week_day_class( date )
    dm = []
    dm << "last-day-of-month" if date.end_of_month == date 
    dm << "first-day-of-month" if date.day == 1 
    case date.cwday
      when 7
        dm = dm + ["sunday", "weekend"]
      when 6
        dm = dm + ["saturday", "weekend"]
    end
    dm.join(" ")
  end

  def clickable_day_class( date, public_holidays )
    if ![7,6].include?( date.cwday ) && !is_holiday?( date, public_holidays )
      "clickable"
    end
  end

  def is_holiday?( date, public_holidays )
    public_holidays.collect( &:date ).include? date
  end

  def get_holiday( date, public_holidays )
    public_holidays.select{ |h| h.date == date }.first
  end

  def calendar_day_cell( date, public_holidays )
    desc = is_holiday?( date, public_holidays ) ? t( get_holiday( date, public_holidays ).code ) : ""
    td_class = [ "day", week_day_class(date), is_holiday?( date, public_holidays ) ? "holiday" : nil, clickable_day_class( date, public_holidays ) ].compact.join(' ')
    content_tag :td, content_tag( :div, date.day, :class => td_class, :id => date, :title => desc )
  end


end
