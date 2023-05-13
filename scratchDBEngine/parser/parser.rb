require_relative 'ast.rb'
require_relative 'constants.rb'

###
  ## Lexical and Semantic analysis for SQL Query
  ## Currently only to able to parse simple Select statements
  ## without any conditions
###
class Parser
  def initialize(query)
    @scratch_parser = {
      :sql_query=> query,
      :iterator => 0,
      :abstract_syntax_tree => AST.new,
      :current_step => nil
    }
    @tokens = query.split
    @scratch_parser[:abstract_syntax_tree].fields = Array.new
  end
  
  # Main function to parse the sql query and generate Abstract Syntax Tree of query
  # Handles FSM for the SQL Grammar
  def parse
    @tokens.each do |token|
      raise_exception if token.nil?
      token.upcase!
      step = @scratch_parser[:current_step]
      case step
      when nil
        case token
        when Select
          @scratch_parser[:abstract_syntax_tree].type = Select
          @scratch_parser[:current_step] = STEP_SELECT
        else
          raise_exception(__method__)
        end
      when STEP_SELECT 
        case token
        when SELECT_ALL_OPERATOR
          @scratch_parser[:current_step] = STEP_FROM
          @scratch_parser[:abstract_syntax_tree].fields = token
        when COMMA_SEPRATED_STRING_MATCH_REGEX
          @scratch_parser[:current_step] = STEP_FROM
          token.split(',').each do |field|
            @scratch_parser[:abstract_syntax_tree].fields.push(field) 
          end
        else
          raise_exception(__method__, message: token)
        end
      when STEP_FROM
        case token
        when FROM_CLAUSE
          @scratch_parser[:current_step] = STEP_FROM_TABLE
        else
          raise_exception(__method__, message: token)
        end
      when STEP_FROM_TABLE
        case token
        when STRING_MATCH_REGEX 
          @scratch_parser[:abstract_syntax_tree].table_name = token
        else
          raise_exception(__method__, message: token)
        end
      end
    end
  end

  def get_ast
    @scratch_parser[:abstract_syntax_tree].inspect
  end

  def raise_exception(method, message: nil)
    raise StandardError.new "[#{method} Encountered error while parsing query with message #{message}]"
  end
end

q = 'select id,name from users'
p = Parser.new(q)
p.parse
puts(p.get_ast)
