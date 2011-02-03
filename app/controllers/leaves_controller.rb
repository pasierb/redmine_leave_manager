class LeavesController < ApplicationController
  unloadable

  #
  # filters ----------------------------------
  before_filter :find_year
  before_filter :find_leaves, :only => [:index, :plan]
  before_filter :find_public_holidays

  def plan
  end

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    @leave = Leave.new( params[:leave] )
    @leave.user = User.current
    respond_to do |format|
      if @leave.save
        format.js { render :template => "leaves/create.js.erb", :layout => false } 
      else
      end
    end
  end

  def destroy
    @leave = Leave.by_user( User.current ).first( :conditions => { :date => params[:id] } )
    respond_to do |format|
      if @leave.destroy
        format.js { render :template => "leaves/destroy.js.erb", :layout => false } 
      end
    end
  end

protected

  def find_year
    @year = params[:year] ? params[:year].to_i : Time.now.year
  end

  def find_leaves
    @leaves = Leave.by_user( User.current ).by_year( @year )
  end

  def find_public_holidays
    @public_holidays = []
  end

end
