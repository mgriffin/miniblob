class MiniblobsController < ApplicationController
  def index
    @svg = Svg.new.svg
    respond_to do |format|
      format.html
      format.svg { render inline: @svg, mime_type: Mime::Type.lookup("image/svg+xml") }
    end
  end
end
