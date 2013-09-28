require_relative "./strategies/base.rb"
require_relative "./strategies/minitest.rb"
require_relative "./strategies/rspec.rb"

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
