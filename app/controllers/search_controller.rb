class SearchController < ApplicationController
  def index
    @results = Search.find(params[:query], params[:object])
    respond_with(@results)
  end
end
