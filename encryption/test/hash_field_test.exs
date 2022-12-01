defmodule Encryption.HashFieldTest do
  use ExUnit.Case
  # our Ecto Custom Type for hashed fields
  alias Encryption.HashField, as: Field

  test ".type is :binary" do
    assert Field.type() == :binary
  end

  test ".cast converts a value to a string" do
    assert {:ok, "42"} == Field.cast(42)
    assert {:ok, "atom"} == Field.cast(:atom)
  end

  test ".dump converts a value to a sha256 hash" do
    {:ok, hash} = Field.dump("hello")

    assert hash ==
      <<131, 181, 60, 124, 58, 199, 196, 125, 6, 51, 65, 188, 52, 80, 18, 139, 163, 193, 9, 127, 138, 233, 18, 94, 220, 10, 16, 211, 57, 219, 156, 229>>
  end

  test "hash converts a value to a sha256 hash with secret_key_base as salt" do
    hash = Field.hash("alex@example.com")

    assert hash ==
      <<16, 225, 109, 29, 119, 14, 159, 33, 44, 43, 92, 71, 244, 187, 52, 103, 65, 142, 70, 42, 204, 25, 108, 28, 232, 236, 67, 1, 98, 157, 181, 151>>
  end

  test ".load does not modify the hash, since the hash cannot be reversed" do
    hash =
      <<16, 231, 67, 229, 9, 181, 13, 87, 69, 76, 227, 205, 43, 124, 16, 75, 46, 161, 206, 219,
        141, 203, 199, 88, 112, 1, 204, 189, 109, 248, 22, 254>>

    assert {:ok, ^hash} = Field.load(hash)
  end

  test ".equal? correctly determines hash equality and inequality" do
    hash1 =
      <<16, 231, 67, 229, 9, 181, 13, 87, 69, 76, 227, 205, 43, 124, 16, 75, 46, 161, 206, 219,
        141, 203, 199, 88, 112, 1, 204, 189, 109, 248, 22, 254>>

    hash2 =
      <<10, 231, 67, 229, 9, 181, 13, 87, 69, 76, 227, 205, 43, 124, 16, 75, 46, 161, 206, 219,
        141, 203, 199, 88, 112, 1, 204, 189, 109, 248, 22, 254>>

    assert Field.equal?(hash1, hash1)
    refute Field.equal?(hash1, hash2)
  end

  test "embed_as/1 returns :self" do
    assert Field.embed_as(:self) == :self
  end
end
