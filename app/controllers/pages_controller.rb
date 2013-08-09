class PagesController < ApplicationController
  def index
    begin
      render params[:template_name], layout: false
    rescue ActionView::MissingTemplate
      render text: 'no template'
    end
  end
end
