abstract class ITravelPlanRepository

  abstract def getAll

  abstract def findById(id : Int32)

  abstract def create(data : Array(Int32))

  abstract def update(id : Int32, data : Array(Int32))
  
  abstract def delete(id : Int32)
end