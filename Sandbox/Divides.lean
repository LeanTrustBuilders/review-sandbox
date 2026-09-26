import TrustAnnotations

/-!
# Divisibility

The library's own notion of divisibility, and its agreement with Lean's.
-/

namespace Sandbox

/-- `d` divides `n`: `n` is a multiple of `d`. Every number divides `0`, and `0` divides only `0`. -/
def Divides (d n : Nat) : Prop := ∃ k, n = d * k

/-- `Divides` is Lean's divisibility of natural numbers. -/
@[specifies Divides "agrees with Lean's `∣` on natural numbers"]
theorem divides_iff_dvd {d n : Nat} : Divides d n ↔ d ∣ n := Iff.rfl

theorem divides_refl (n : Nat) : Divides n n := ⟨1, (Nat.mul_one n).symm⟩

theorem divides_trans {a b c : Nat} (h₁ : Divides a b) (h₂ : Divides b c) : Divides a c :=
  divides_iff_dvd.mpr (Nat.dvd_trans (divides_iff_dvd.mp h₁) (divides_iff_dvd.mp h₂))

end Sandbox
