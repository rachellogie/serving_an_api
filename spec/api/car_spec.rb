require 'rails_helper'

describe "Make Cars API" do

  describe "GET /cars" do
    it "returns a list of cars" do

      subaru = create_make(name: "Subaru")
      toyota = create_make(name: "Toyota")

      red = create_car(color: "red", purchased_on: "1973-10-04", doors: 4, make_id: subaru.id)
      blue = create_car(color: "blue", purchased_on: "2012-01-24", doors: 2, make_id: toyota.id)

      get '/cars', {}, {'Accept' => 'application/json'}

      expected_response = {
        "_links" => {
          "self" => {
            "href" => cars_path
          }
        },
        "_embedded" => {
          "cars" => [
            {
              "_links" => {
                "self" => {
                  "href" => car_path(red)
                },
                "make" => {
                  "href" => make_path(subaru)
                }
              },
              "id" => red.id,
              "color" => "red",
              "doors" => 4,
              "purchased_on" => "1973-10-04"
            },
            {
              "_links" => {
                "self" => {
                  "href" => car_path(blue)
                },
                "make" => {
                  "href" => make_path(toyota)
                }
              },
              "id" => blue.id,
              "color" => "blue",
              "doors" => 2,
              "purchased_on" => "2012-01-24"
            }
          ]
        }
      }

      expect(response.code.to_i).to eq 200
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end