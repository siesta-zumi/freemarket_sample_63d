class Status < ActiveHash::Base
  self.data = [
    {id: 1, name: '新品'}, {id: 2, name: '中古'}, {id: 3, name: '傷あり'}
  ]
end