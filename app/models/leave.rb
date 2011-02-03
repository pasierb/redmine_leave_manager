class Leave < ActiveRecord::Base

  #
  # associations  ----------------
  belongs_to :user

  #
  # scopes
  named_scope :by_year, lambda { |y| { :conditions => { :date => Date.civil(y)..Date.civil(y).end_of_year } } }
  named_scope :by_user, lambda { |u| { :conditions => { :user_id => u.id }  } }

end
