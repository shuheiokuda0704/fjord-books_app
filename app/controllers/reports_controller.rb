# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.includes(:user).order(:created_at).page(params[:page])
  end

  def show
    @report = Report.includes(comments: :user).find(params[:id])
  end

  def new
    @report = Report.new
  end

  def edit
    @report = current_user.reports.find_by(id: params[:id])
    redirect_to report_url unless @report
  end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = current_user.reports.find_by(id: params[:id])
    redirect_to report_url unless @report

    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = current_user.reports.find_by(id: params[:id])
    redirect_to report_url unless @report

    @report.destroy
    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:title, :content)
  end
end
