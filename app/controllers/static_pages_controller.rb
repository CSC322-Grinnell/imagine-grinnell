class StaticPagesController < ApplicationController
  def home; end

  def dashboard; end

  def map; end

  def produce_by_garden
    @all_crops = {}
    @num_crops = Crop.all.count
    Crop.all.each do |crop|
      garden_name = Garden.find(crop.garden_id).name

      crop_produce_name = Produce.find(crop.produce).name
      crop_item = [crop_produce_name]
      crop_item << crop.description ? crop.description : '-'

      if @all_crops[garden_name]
        @all_crops[garden_name] << crop_item
      else
        @all_crops[garden_name] = [crop_item]
      end
    end
  end
end
