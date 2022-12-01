defmodule Encryption.AES do
  @aad "AES256GCM" # Use AES 256 Bit Keys for Encryption.

  def encrypt(plaintext) do
    iv = :crypto.strong_rand_bytes(16) # create random Initialization Vector
    key = get_key()    # get the *latest* key in the list of encryption keys
    # get latest ID;
    key_id = get_key_id()
    # {ciphertext, tag} = :crypto.block_encrypt(:aes_gcm, key, iv, {@aad, plaintext, 16})
    {ciphertext, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, to_string(plaintext), @aad, true)
    # Finally we "return" the iv with the ciphertag, key_id and the ciphertext, this is what we store in the database. Including the IV
      #and ciphertag and key_od is essential for allowing decryption, without these two pieces of data, we would not be able to "reverse"
      # the process.
    final_value = iv <> tag <> <<key_id::unsigned-big-integer-32>> <> ciphertext
    final_value
  end

  # if get key is called with no params it invokes get_key_id then get_key with key_id as a first parameter to
  # return key_id position on the encryption_keys keyword list
  defp get_key do
    get_key_id() |> get_key
  end

  # uses the keyword list returned by encryption_keys and it passes his value to Enum.at as a first parameter as a second parameter the key_id
  # to be returned using the Enum.at function.
  defp get_key(key_id) do
    encryption_keys() |> Enum.at(key_id)
  end

  # Counts the number of elements on the keyword list returned by encryption_keys fn and it rest 1 to the count to return his value
  defp get_key_id do
    Enum.count(encryption_keys()) - 1
  end

  # returns a keyword list using get_env function as a first paramter the app and the second the key
  # since is a keyword list we can obbtain the value to return at the end with "[:keys]"
  defp encryption_keys do
    Application.get_env(:encryption, Encryption.AES)[:keys]
  end

  def decrypt(ciphertext) do
    # using binary pattern matching to get the initial vector used on the decrypt fn, tag
    # and cyphertext
    <<iv::binary-16, tag::binary-16, key_id::unsigned-big-integer-32, ciphertext::binary>> =
      ciphertext
      # this at the end will return the encrypted text.
    final_value = :crypto.crypto_one_time_aead(:aes_256_gcm, get_key(key_id), iv, ciphertext, @aad, tag, false)
    final_value
  end
end
