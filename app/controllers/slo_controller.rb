class SloController < ApplicationController
  def front
    logger.info("params: #{@params}")
  end

  def back
    logger.info("params: #{@params}")
  end
end
