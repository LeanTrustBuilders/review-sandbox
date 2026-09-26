import Sandbox.Divides

/-!
# Prime numbers
-/

namespace Sandbox

/-- A prime number: a natural number whose only divisors are `1` and itself. -/
def IsPrime (p : Nat) : Prop := 1 ≤ p ∧ ∀ d, Divides d p → d = 1 ∨ d = p

@[example_of IsPrime]
theorem isPrime_two : IsPrime 2 := by
  refine ⟨by decide, fun d hd => ?_⟩
  have hd' := divides_iff_dvd.mp hd
  have h₁ : d ≤ 2 := Nat.le_of_dvd (by decide) hd'
  have h₂ : 0 < d := Nat.pos_of_dvd_of_pos hd' (by decide)
  omega

@[nonexample_of IsPrime]
theorem not_isPrime_four : ¬ IsPrime 4 := fun h => by
  have := h.2 2 ⟨2, rfl⟩
  omega

/-- Every number at least `2` has a prime divisor, itself at least `2`. -/
theorem exists_prime_divides : ∀ n, 2 ≤ n → ∃ p, 2 ≤ p ∧ IsPrime p ∧ Divides p n := by
  intro n
  induction n using Nat.strongRecOn with
  | ind n ih =>
    intro hn
    by_cases hp : ∀ d, Divides d n → d = 1 ∨ d = n
    · exact ⟨n, hn, ⟨by omega, hp⟩, divides_refl n⟩
    · have : ∃ d, Divides d n ∧ d ≠ 1 ∧ d ≠ n :=
        Classical.byContradiction fun h => hp fun d hd =>
          Classical.byContradiction fun hne => h ⟨d, hd, fun h₁ => hne (Or.inl h₁), fun h₂ => hne (Or.inr h₂)⟩
      obtain ⟨d, hd, h₁, h₂⟩ := this
      have hd' := divides_iff_dvd.mp hd
      have hpos : 0 < d := Nat.pos_of_dvd_of_pos hd' (by omega)
      have hle : d ≤ n := Nat.le_of_dvd (by omega) hd'
      obtain ⟨p, hp2, hpp, hpd⟩ := ih d (by omega) (by omega)
      exact ⟨p, hp2, hpp, divides_trans hpd hd⟩

end Sandbox
