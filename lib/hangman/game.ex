 defmodule Hangman.Game do

  defmodule GameState do
   #   defstruct word: Hangman.Dictionary.random_word, turnsLeft: 10, correctGuess: [], incorrectGuess: [] ,tempWord: Hangman.Dictionary.random_word
    defstruct word: "ashwini", turnsLeft: 10, correctGuess: [], incorrectGuess: [], tempWord: "ashwini"
  end
 

   def new_game do
        r= random_word()
        IO.puts("")
        %GameState{ word: r, tempWord: r }
   end

   def new_game(word) do
        game_state = %GameState{ word: String.downcase(word) , tempWord:  String.downcase(word) }
        game_state
   end


   def word_length(%{ word: word }) do
        String.length(word)
   end

   def letters_used_so_far(state) do
        state.correctGuess ++ state.incorrectGuess
   end
 
 
    def turns_left(state) do
        state.turnsLeft
   end

   def letters_used_so_far(state) do
        state.correctGuess ++ state.incorrectGuess
   end


  def word_as_string_string(state, reveal \\ false) do
      if(reveal) do
         state
      else
          lst = String.split(state.word, "", trim: true)
         _str=  Enum.map( lst, fn(x) ->
            #    IO.puts(x)
            if Enum.member?(state.correctGuess,to_string(x)) , do: x , else:  "-"   end 
            )
          Enum.join(_str,"")
      end
    end

def make_move(state, guess) do
 
        if(String.contains?(state.tempWord, guess)) do
            new_state =  %GameState{state | correctGuess: state.correctGuess  ++[guess], turnsLeft: state.turnsLeft - 1 , tempWord: String.replace(state.tempWord, guess, "", global: false)}
              tuple=  {new_state,  :good_guess, guess }
            if( String.strip(new_state.tempWord) == ""    ) do 
                tuple=  {new_state, :won, guess }  
            end
 
        else
          new_state=  %GameState{state | incorrectGuess: state.incorrectGuess ++ [guess], turnsLeft: state.turnsLeft - 1}
           tuple=  {new_state,:bad_guess, guess }
        
            if ( new_state.turnsLeft == 0) do 
            tuple=  {new_state,:lost, guess }
            end 
        end

        tuple
  end




@moduledoc """
  We act as an interface to a wordlist (whose name is hardwired in the
  module attribute `@word_list_file_name`). The list is formatted as
  one word per line.
  """

  @word_list_file_name "../../assets/words.8800"

  @doc """
  Return a random word from our word list. Whitespace and newlines
  will have been removed.
  """

  @spec random_word() :: binary
  def random_word do
    word_list
    |> Enum.random
    |> String.trim
  end

  @doc """
  Return a list of all the words in our word list of a given length.
  Whitespace and newlines will have been removed.
  """

  @spec words_of_length(integer)  :: [ binary ]
  def words_of_length(len) do
    word_list
    |> Stream.map(&String.trim/1)
    |> Enum.filter(&(String.length(&1) == len))
  end


  ###########################
  # End of public interface #
  ###########################

  defp word_list do
    @word_list_file_name
    |> File.open!
    |> IO.stream(:line)
  end



end