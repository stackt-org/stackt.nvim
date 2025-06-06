- [ ] fetcher for different registry types
- [ ] converter for yaml to json
- [ ] merger for debuggers from registry into one file
- [ ] installer for debuggers
- [ ] use debuggers folder to check if package is installed

- [ ] mason-like ui for installing debuggers
- [ ] build connection for installed debuggers to dapui
- [ ] default dapui setup

- [ ] build base config for plugin
- plugin folder structure: nvim-data/stackt/
  - debuggers/ (installed debuggers)
    - <debugger-name>/ (debugger name)
  - registries/ (installed registries)
    - github/ (registries from github)
      - stackt-registry/
        - registry.json (registry config)
      - <registry-name>/
        - registry.json (registry config)
  - staging/ (staging area for installed debuggers)

---

### Core Functionality

- [ ] **Fetcher for Registry Types**
  - [ ] Support GitHub/GitLab (HTTPS/SSH), HTTP/HTTPS URLs, and local paths.
  - [ ] Handle authentication (SSH keys, PATs).
  - [ ] Validate registry schemas and verify signatures (optional).
  - [ ] Implement caching and background registry refreshes.
- [ ] **YAML-to-JSON Converter**

  - [ ] Validate YAML schemas pre-conversion.
  - [ ] Gracefully handle malformed YAML with user-friendly errors.
  - [ ] Strip YAML comments during conversion.
  - [ ] Add unit tests for edge cases (nested fields, arrays).

- [ ] **Debugger Merger**

  - [ ] Resolve conflicts via priority (user-local > remote) and merge strategies.
  - [ ] Deduplicate by `debugger-name` + `version`.
  - [ ] Sort versions with semver compliance.
  - [ ] Generate merged `debuggers.json` with metadata.

- [ ] **Debugger Installer**

  - [ ] Support OS/arch-specific installations (e.g., `linux-x64`, `win32-arm64`).
  - [ ] Check dependencies (compilers, runtimes).
  - [ ] Add post-install hooks (permissions, `PATH` updates).
  - [ ] Implement rollback for failed installs.

- [ ] **Installed Debugger Checks**
  - [ ] Track versions in `debuggers/version.lock`.
  - [ ] Health checks (binaries, minimal DAP tests).
  - [ ] Auto-cleanup corrupted installations.

---

### UI & Integration

- [ ] **Mason-Like UI**

  - [ ] Build floating window with search, status indicators, and progress bars.
  - [ ] Add keybindings for install/update/uninstall, details toggle, and registry refresh.
  - [ ] Suggest debuggers for unsupported filetypes and notify about updates.

- [ ] **DAP Integration**
  - [ ] Auto-generate `dap-configurations` mapping filetypes to debuggers.
  - [ ] Preconfigure `dapui` with defaults and event watchers.
  - [ ] Fallback to manual setup if `dapui` is missing.

---

### Configuration & Structure

- [ ] **Base Plugin Config**

  - [x] Define default settings:
    ```lua
    {
      registries = { { url = "github:stackt/stackt-registry" } },
      auto_installs = true,
    }
    ```
  - [ ] Validate configs (e.g., registry URLs).
  - [ ] Add `:StacktHealth` command for diagnostics.

- [ ] **Folder Structure**
  - [ ] Use atomic writes via `staging/` and lockfiles.
  - [ ] Store registry metadata in `registries/<source>/metadata.json`.
  - [ ] Add `logs/` directory for debugging.

---

### Documentation & Testing

- [ ] **Documentation**

  - [ ] Write `:help stackt.txt` covering registries, debuggers, and troubleshooting.
  - [ ] Provide example configs for popular debuggers (e.g., `cpptools`, `debugpy`).

- [ ] **Testing**
  - [ ] Create mock registries for integration tests.
  - [ ] Test cross-platform path handling (Windows/POSIX).
  - [ ] Set up CI with Neovim version matrix (0.9+, nightly).
