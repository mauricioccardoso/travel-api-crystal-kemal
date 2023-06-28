struct LocationsOptimizedFormated
  include JSON::Serializable

  getter id : String
  getter name : String
  getter type : String
  getter dimension : String
  getter residents : Array(Resident)

  struct Resident
    include JSON::Serializable

    getter episode : Array(Episode)

    struct Episode
      include JSON::Serializable

      getter id : String
    end
  end
end