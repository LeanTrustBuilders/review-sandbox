import TrustAnnotations

/-!
# Factorial
-/

namespace Sandbox

/-- `n!`, the product `1 * 2 * ⋯ * n`, with `0! = 1`. -/
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

@[example_of factorial]
theorem factorial_three : factorial 3 = 6 := rfl

theorem factorial_pos (n : Nat) : 0 < factorial n := by
  induction n with
  | zero => decide
  | succ n ih => exact Nat.mul_pos (Nat.succ_pos n) ih

/-- Every number from `1` to `n` divides `n!`. -/
theorem dvd_factorial {k n : Nat} (hk : 0 < k) (h : k ≤ n) : k ∣ factorial n := by
  induction n with
  | zero => omega
  | succ n ih =>
    show k ∣ (n + 1) * factorial n
    rcases Nat.lt_or_ge k (n + 1) with hlt | hge
    · exact Nat.dvd_trans (ih (by omega)) (Nat.dvd_mul_left (factorial n) (n + 1))
    · have : k = n + 1 := by omega
      subst this
      exact Nat.dvd_mul_right _ _

end Sandbox
