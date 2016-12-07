require_relative '../spec_helper'

describe "" do
  describe "validations" do
    it "won't allow a conditions without date to be saved" do
      invalid_condition = Condition.write(max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without max_temperature_f to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without min_temperature_f to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without mean_humidity to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without mean_visibility_miles to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_humidity: 20,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without max_wind_speed_mph to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without precipitation_inches to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          min_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23)
      
      expect(invalid_condition).to_not be_valid
    end
    it "won't allow a conditions without mean_temperature_f to be saved" do
      invalid_condition = Condition.write(date: "2013-12-12",
                                          max_temperature_f: 45,
                                          mean_temperature_f: 20,
                                          mean_humidity: 20,
                                          mean_visibility_miles: 1,
                                          max_wind_speed_mph: 23,
                                          precipitation_inches: 0)
      
      expect(invalid_condition).to_not be_valid
    end 
  end

  describe "Dashboard Methods" do
    it "can chunk days with high temperatures in 10 degs" do
      Condition.write(date: "2013-12-12",
                      max_temperature_f: 45,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-12-13",
                      max_temperature_f: 47,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-12-14",
                      max_temperature_f: 32,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
   
      expect(Condition.days_with_high_temps_between(40..49).count).to eq(2)
    end

    it "can pull trips for a condition" do
      Station.write(name: "TestStation3",
                    lat: 3.1,
                    long: 3.2,
                    dock_count: 3,
                    city_name: "TestCityName3",
                    installation_date: "2011-11-11")
      Trip.write(duration: 90,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      condition = Condition.write(date: "2013-12-12",
                                  max_temperature_f: 45,
                                  mean_temperature_f: 20,
                                  min_temperature_f: 20,
                                  mean_humidity: 20,
                                  mean_visibility_miles: 1,
                                  max_wind_speed_mph: 23,
                                  precipitation_inches: 0)
      
      expect(condition.trips.count).to eq(2)
    end

    it "can find average rides for day in max_temp chunks" do
      Station.write(name: "TestStation3",
                    lat: 3.1,
                    long: 3.2,
                    dock_count: 3,
                    city_name: "TestCityName3",
                    installation_date: "2011-11-11")
      Trip.write(duration: 90,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 45,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 76,
                start_date: "2013-10-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 7,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 70,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Condition.write(date: "2013-12-12",
                      max_temperature_f: 32,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-10-12",
                      max_temperature_f: 37,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-06-13",
                      max_temperature_f: 39,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0) 
      
      expect(Condition.average_number_of_rides_in_range(31..40)).to eq(2.33)
    end

    it "highest number of rides for day in max_temp chunks" do
      Station.write(name: "TestStation3",
                    lat: 3.1,
                    long: 3.2,
                    dock_count: 3,
                    city_name: "TestCityName3",
                    installation_date: "2011-11-11")
      Trip.write(duration: 90,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 45,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 76,
                start_date: "2013-10-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 7,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 70,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Condition.write(date: "2013-12-12",
                      max_temperature_f: 32,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-10-12",
                      max_temperature_f: 37,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-06-13",
                      max_temperature_f: 39,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
    
      expect(Condition.highest_number_of_rides_in_range(31..40)).to eq(3)
    end

    it "lowest number of rides for day in max_temp chunks" do
      Station.write(name: "TestStation3",
                    lat: 3.1,
                    long: 3.2,
                    dock_count: 3,
                    city_name: "TestCityName3",
                    installation_date: "2011-11-11")
      Trip.write(duration: 90,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 45,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-12-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 76,
                start_date: "2013-10-12",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 23,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 7,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Trip.write(duration: 70,
                start_date: "2013-06-13",
                start_station_name: "TestStation3",
                end_date: "2011-3-6",
                end_station_name: "TestStation3",
                bike_id: 3,
                subscription_type: "Subscriber", 
                zipcode: 80211)
      Condition.write(date: "2013-12-12",
                      max_temperature_f: 32,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-10-12",
                      max_temperature_f: 37,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-06-13",
                      max_temperature_f: 39,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
    
      expect(Condition.lowest_number_of_rides_in_range(31..40)).to eq(1)
    end

    it "chunks days with precipitation into half_inches" do 
      Condition.write(date: "2013-12-12",
                      max_temperature_f: 45,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-12-13",
                      max_temperature_f: 47,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)
      Condition.write(date: "2013-12-14",
                      max_temperature_f: 32,
                      mean_temperature_f: 20,
                      min_temperature_f: 20,
                      mean_humidity: 20,
                      mean_visibility_miles: 1,
                      max_wind_speed_mph: 23,
                      precipitation_inches: 0)      
    end
  end

end