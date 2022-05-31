class MiniblobsController < ApplicationController
  def index
    @svg = Svg.new.svg
  end
end
