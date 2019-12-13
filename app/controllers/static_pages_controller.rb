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
      crop_item = {
        :name => crop_produce.name,
        :desc => '-',
        :ripe => '-'
      }
      if crop.description # Add the description, if there is one
        crop_item[:desc] = crop.description
      end
      
      # Determine ripeness
      today = Date.today
      if crop_produce.type == "AnnualProduce"
        planted_date = Date::strptime(crop.planted_at, '%m/%d/%Y')
        ripe_date = planted_date + crop_produce.duration
        is_ripe = today <=> ripe_date >= 0 # means: is today on or after ripe_date
        crop_item[:ripe] = if is_ripe
          'Ripe now'
        else
          ripe_date.strftime('Ripe on %-m/%-d/%Y')
        end
      else
        start_date_temp = crop_produce.start_date
        end_date_temp = crop_produce.end_date

        # If a new year started between the start date and end date, these two lines will
        # cause the start date to come after the end date
        start_date = Date.new(today.year, start_date_temp.month, start_date_temp.day)
        end_date = Date.new(today.year, end_date_temp.month, end_date_temp.day)
        if start_date <=> end_date > 0 # means: does start_date come after end_date
          # If the two lines above broke that new year thing, this will fix it
          end_date >> 12 # subtract a year
        end

        # Suppose the start date is in November and the end date is in February
        # We want to make sure that a date in December evaluates to being between those dates
        # and a date in January will also evaluate to being between those dates
        # If today is in January 2000, then it won't fall between the start_date (Nov 2000)
        # and end_date (Feb 2001) that we defined above. Therefore, we also want to check
        # if the date is between Nov 1999 and Feb 2000 (i.e. subtract a year from the range)
        start_date_prev = start_date << 12 # subtract a year
        end_date_prev = end_date << 12 # subtract a year

        # Check if today falls in one of the two ranges we have

        # below means: is today between start_date and end_date inclusive
        is_ripe_first_range = today <=> start_date >= 0 && end_date <=> today >= 0
        # below means: is today between start_date_prev and end_date_prev inclusive
        is_ripe_second_range = today <=> start_date_prev >= 0 && end_date_prev <=> today >= 0

        is_ripe = is_ripe_first_range || is_ripe_second_range
        crop_item[:ripe] = if is_ripe
          'Ripe now'
        else
          `Ripe between #{start_date.strftime('%-m/%-d')} and #{end_date.strftime('%-m/%-d')}`
        end
      end

      # Assemble the array of all crops
      if @all_crops[garden_name]
        @all_crops[garden_name] << crop_item
      else
        @all_crops[garden_name] = [crop_item]
      end
    end
  end
end
