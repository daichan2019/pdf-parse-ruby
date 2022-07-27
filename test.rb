class TestClass
  def initialize(name)
    @name = name
  end

  def hoge
    hoge = @name
  end
end


pp fuga = TestClass.new('sato')
var = fuga.hoge
pp var
