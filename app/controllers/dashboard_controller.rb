class DashboardController < ApplicationController
  def index
    @upcoming_treatments = Treatment.where.not(next_due_date: nil).order(:next_due_date).limit(5)
  end
end
