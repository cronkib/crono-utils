# Cronkib's Helpful Utilities

## GPG-Reduce

A streamlined wrapper around the GPG CLI.

Usage: `gpgr <command> <options>`

Supported Commands: 
```
encrypt         <receiver> <filename>   -- Encrypt file to send
decrypt         <filename>              -- Decrypt file from trusted sender
import          <filename>              -- Import a trusted user's public key
export          <name>                  -- Export public key of user
fingerprint     <name>                  -- Show fingerprint for user
```