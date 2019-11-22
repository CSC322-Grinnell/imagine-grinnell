class StaticPagesController < ApplicationController
  def home; end

  def dashboard; end

  def map; end

  def produce_by_garden
    @all_crops = {}
    @num_crops = Crop.all.count
    Crop.all.each do |crop|
      garden_name = Garden.find(crop.garden_id).name

      crop_produce = Produce.find(crop.produce)
      crop_item = [crop_produce.name] # Add the name
      crop_item << if crop.description # Add the description, if there is one
        crop.description
      else
        '-'
      end
      
      # Calculate days to ripeness
      # WAIT UNTIL DATES CHANGED IN DB
      # Plan for annual produce:
      #  Get date planted in date object form
      #  Add produce.duration (an int) to that date object, yields date when crop will be ripe
      #  Get current date in date object form
      #  Determine the difference in days between current date and date when ripe
      #  If date when ripe is in the past, then the crop is ripe now
      #  If the crop is not ripe now, list the date when ripe
      # Plan for perennial produce:
      #  Get current date in date object form
      #  If the current date is within the date range given in the produce, then the crop is now ripe
      #  If the crop is not ripe now, list the ripeness date range
      crop_item << "[ Ripeness Here ]" # placeholder

      # Assemble the array of all crops
      if @all_crops[garden_name]
        @all_crops[garden_name] << crop_item
      else
        @all_crops[garden_name] = [crop_item]
      end
    end
  end
end
