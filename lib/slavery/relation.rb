class ActiveRecord::Relation
  attr_accessor :slavery_target

  # Supports queries like User.on_slave.to_a
  def exec_queries_with_slavery
    if slavery_target == :slave
      Slavery.on_slave { exec_queries_without_slavery }
    else
      exec_queries_without_slavery
    end
  end

  # Supports queries like User.on_slave.count
  def calculate_with_slavery(operation, column_name)
    if slavery_target == :slave
      Slavery.on_slave { calculate_without_slavery(operation, column_name) }
    else
      calculate_without_slavery(operation, column_name)
    end
  end

  alias_method_chain :exec_queries, :slavery
  alias_method_chain :calculate, :slavery
end
