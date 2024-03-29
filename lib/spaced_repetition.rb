#http://www.supermemo.com/english/ol/sm2.htm
require 'date'

module SpacedRepetition
  class Sm2
    def initialize(score, prev_interval=0, prev_ef=2.5)
      @prev_ef = prev_ef
      @prev_interval = prev_interval
      @score = score

      @calculated_interval = nil
      @calculated_ef = nil
      @repetition_date = nil

      #if score is below 3 start repetition from the begining, but without changing easiness_factor
      if @score < 3

        @calculated_ef = @prev_ef
      	@calculated_interval = 0
      else
        calculate_easiness_factor
      	calculate_interval
      end
      	calculate_date
    end

    def interval
      @calculated_interval
    end

    def easiness_factor
      @calculated_ef
    end

    def next_repetition_date
      @repetition_date
    end

    private
    
    def calculate_interval
      if @prev_interval == 0
        @calculated_interval = 1
      elsif @prev_interval == 1
        @calculated_interval = 6
      else
        @calculated_interval = (@prev_interval*@prev_ef).to_i
      end
    end

    def calculate_easiness_factor
      @calculated_ef = @prev_ef+(0.1-(5-@score)*(0.08+(5-@score)*0.02))
      if @calculated_ef < 1.3
        @calculated_ef = 1.3
      end
      @calculated_ef
    end

    def calculate_date
      @repetition_date = Date.today + @calculated_interval
    end
  end
end
