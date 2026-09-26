import Sandbox.Prime
import Sandbox.Factorial

/-!
# There are infinitely many primes

Euclid's theorem: past any number there is a prime, namely any prime divisor of `n! + 1`.
-/

namespace Sandbox

/-- A property holds of infinitely many natural numbers: past any number, some number has it. -/
def InfinitelyMany (P : Nat → Prop) : Prop := ∀ n, ∃ m, n < m ∧ P m

/-- There are infinitely many prime numbers. -/
@[claim "Euclid, Elements, Book IX, Proposition 20"]
theorem infinitely_many_primes : InfinitelyMany IsPrime := by
  intro n
  obtain ⟨p, hp2, hp, hpd⟩ :=
    exists_prime_divides (factorial n + 1) (by have := factorial_pos n; omega)
  refine ⟨p, Nat.lt_of_not_le fun hle => ?_, hp⟩
  have h₁ : p ∣ factorial n := dvd_factorial (by omega) hle
  have h₂ : p ∣ 1 := (Nat.dvd_add_right h₁).mp (divides_iff_dvd.mp hpd)
  have := Nat.eq_one_of_dvd_one h₂
  omega

end Sandbox
