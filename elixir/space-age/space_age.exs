defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @one_year 31557600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds), do: seconds / ( @one_year * multiplier(planet) )

  defp multiplier(:mercury), do: 0.2408467
  defp multiplier(:venus), do: 0.61519726
  defp multiplier(:earth), do: 1
  defp multiplier(:mars), do: 1.8808158
  defp multiplier(:jupiter), do: 11.862615
  defp multiplier(:saturn), do: 29.447498
  defp multiplier(:uranus), do: 84.016846
  defp multiplier(:neptune), do: 164.79132
end
