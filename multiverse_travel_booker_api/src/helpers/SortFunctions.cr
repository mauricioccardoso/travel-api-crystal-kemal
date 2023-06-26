def sortLocations (locations)
  sortedLocations = locations.sort do |location1, location2|
    popularityDimensao1 = calcPopularityDimension(locations, location1.dimension)
    popularityDimensao2 = calcPopularityDimension(locations, location2.dimension)
  
    if popularityDimensao1 == popularityDimensao2
      popularityLocal1 = calcPopularityLocal(location1)
      popularityLocal2 = calcPopularityLocal(location2)
      if popularityLocal1 == popularityLocal2
        location1.name <=> location2.name
      else
        popularityLocal1 <=> popularityLocal2
      end
    else
      popularityDimensao1 <=> popularityDimensao2
    end
  end

  sortedLocations
end

def calcPopularityLocal(local : LocationsOptimizedFormated) : Int32
  local.residents.flat_map { |resident| resident.episode }.size
end

def calcPopularityDimension(locations : Array(LocationsOptimizedFormated), dimension : String) : Float64
  locais_dimensao = locations.select { |location| location.dimension == dimension }
  total_locais = locais_dimensao.size

  popularityTotal = locais_dimensao.sum { |location| calcPopularityLocal(location) }
  popularityTotal.to_f / total_locais.to_f
end