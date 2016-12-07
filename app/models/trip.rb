require_relative '../models/subscription'

class Trip < ActiveRecord::Base
  validates :duration,
            :start_date,
            :start_station_id,
            :end_date,
            :end_station_id,
            :bike_id,
            :subscription_id, 
            :zipcode,
               presence: true
  belongs_to :subscription
  belongs_to :start_station, class_name: "Station", foreign_key: "start_station_id"
  belongs_to :end_station, class_name: "Station", foreign_key: "end_station_id"
  belongs_to :test_output, class_name: "Station", foreign_key: "end_station_id"
  

def self.test_output
  self.end_station
  super
end

def self.db_date_matcher(input_date)
  Time.new(input_date)
end

def self.start_date_clean
  db_date_matcher(self.start_date)
end

  def self.import(trip_details)
    self.create(subscription_id: find_subscription_id(trip_details[:subscription_type]),
                duration: trip_details[:duration],
                start_date: trip_details[:start_date],
                start_station_id: find_station_id(trip_details[:start_station_name]),
                end_station_id: find_station_id(trip_details[:end_station_name]),
                end_date: trip_details[:end_date],
                bike_id: trip_details[:bike_id],
                zipcode: trip_details[:zipcode])
  end

  def self.write(trip_details)
    self.find_or_create_by(subscription_id: find_subscription_id(trip_details[:subscription_type]),
                          duration: trip_details[:duration],
                          start_date: trip_details[:start_date],
                          start_station_id: find_station_id(trip_details[:start_station_name]),
                          end_station_id: find_station_id(trip_details[:end_station_name]),
                          end_date: trip_details[:end_date],
                          bike_id: trip_details[:bike_id],
                          zipcode: trip_details[:zipcode])
  end

  def self.find_subscription_id(subscription_type)
    Subscription.write(name: subscription_type).id
  end

  def self.longest_ride
    Trip.maximum(:duration)
  end

  def self.station_with_most_starting_rides
    most_common = Trip.group(:start_station_id).order('count_id DESC').limit(1).count(:id)
    Station.find(most_common.keys.first)
  end

  def self.least_ridden_bike 
    least_common = Trip.group(:bike_id).order('count_id ASC').limit(1).count(:id)
    least_common.keys.first
  end

  def self.trips_by_bike(given_bike_id)
    where(bike_id: given_bike_id).count
  end

  def self.find_station_id(station_name)
    return "This station has not been added to the database yet" if Station.find_by(name: station_name).nil?
    Station.find_by(name: station_name).id
  end

  def self.average_duration_of_a_ride
    average(:duration)
  end

  def self.trip_count_for_stations_as_starting_place_all
    Trip.group(:start_station_id).order("count_start_station_id desc").count("start_station_id")
  end

  def self.station_with_most_rides_as_starting_place
    start_station_id_count_list = trip_count_for_stations_as_starting_place_all
    start_station_id = start_station_id_count_list.first.first
    Station.find(start_station_id)
  end

  def self.most_ridden_bike_with_total_number_of_rides_for_that_bike_all
    Trip.group(:bike_id).order("count_bike_id desc").count("bike_id")
  end

  def self.most_ridden_bike_with_total_number_of_rides_for_that_bike
    bike_ridden_id_count_list = most_ridden_bike_with_total_number_of_rides_for_that_bike_all
    {
      :most_ridden_bike_id => bike_ridden_id_count_list.first.first,
      :total_number_of_rides => bike_ridden_id_count_list.first.last
    }
  end

  def self.date_with_highest_number_of_trips_with_count_of_those_trips_all
    Trip.group(:start_date).order("count_start_date desc").count("start_date")
  end

  def self.date_with_highest_number_of_trips_with_count_of_those_trips
    per_date_ride_count_list = date_with_highest_number_of_trips_with_count_of_those_trips_all
    {
      :date_with_most_trips => per_date_ride_count_list.first.first,
      :total_number_of_rides => per_date_ride_count_list.first.last
    }
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.rides_started_here(station)
    where(start_station_id: station).count
  end

  def self.monthly_rides
    Trip.group(:start_date).order("count_start_station_id DESC").count(:start_station_id)
  end

  # def most_used_bike(station_id)
  #   station = Station.find(station_id)
  #   Trip.group(:bike_id).order(count_trip)
  # end

  def self.subscription_types
    test = Trip.group(:subscription_id).order('count_subscription_id DESC').count(:subscription_id)
  end
end