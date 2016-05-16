class Employee
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def boss=(boss)
    @boss = boss
    boss.subordinates << self
  end

  def bonus(multiplier)
    unless self.is_a?(Manager)
      salary * multiplier
    else
      self.subordinates.map(&:salary).inject(&:+) * multiplier
    end
  end
end

class Manager < Employee
  attr_accessor :subordinates
  def initialize(name, title, salary, boss, subordinates)
    @subordinates = subordinates
    super(name, title, salary, boss)
  end

  def boss=(boss)
    super
    boss.subordinates += self.subordinates
  end
end


if __FILE__ == $PROGRAM_NAME
  david = Employee.new("David", "TA", 10_000, nil)
  shawna = Employee.new("Shawna", "TA", 12_000, nil)
  darren = Manager.new("Darren", "TA Manager", 78_000, nil, [])
  ned = Manager.new("Ned", "Founder", 1_000_000, nil, [])
  david.boss = darren
  shawna.boss = darren
  darren.boss = ned
  p ned.bonus(5) # => 500_000
  p darren.bonus(4) # => 88_000
  p david.bonus(3) # => 30_000
end
