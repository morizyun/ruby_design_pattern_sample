Dir[File.expand_path("../strategies/*.rb", __FILE__)].each {|f|
  require f
}

class TestCaseExplain
  #
  # == test_caseのstrategyをうけとります
  #
  def initialize(test_case)
    @test_case = test_case
  end

  # strategy classにdelegate
  def execute
    @test_case.execute
  end
end

TestCaseExplain.new(Rspec.new).execute
TestCaseExplain.new(Minitest.new).execute
TestCaseExplain.new(TestUnit.new).execute
