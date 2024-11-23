import * as os from "node:os";
import * as fs from "node:fs/promises";
import * as path from "node:path";
import * as util from "node:util";
import { exec as nodeExec } from "node:child_process";
const exec = util.promisify(nodeExec);

const HOME = os.homedir();
const XDG_CONFIG_HOME = process.env.XDG_CONFIG_HOME || path.join(HOME, ".config");
const DOTFILES_HOME = path.dirname(__dirname);

const MY_HOME = path.join(DOTFILES_HOME, "home");
const MY_XDG_CONFIG_HOME = path.join(DOTFILES_HOME, "xdg_config");

main();

async function main() {
  await createSymlinks();

  await generateShellProfile();

  await installPackages(
    "brew",
    ["git-delta", "fd", "fzf", "neovim", "pipx", "ripgrep", "tmux"],
    name => `brew ls --versions "${name}" >/dev/null || brew install "${name}"`,
  );

  await installPackages(
    "npm",
    ["@antfu/ni", "npkill", "pnpm", "prettier", "sql-formatter"],
    name => `npm list --global "${name}" >/dev/null || npm install -g "${name}"`,
  );

  await installPackages(
    "pip",
    ["black", "flake8", "isort"],
    name => `command -v "${name}" >/dev/null  || pipx install "${name}"`,
  );
}

async function createSymlinks() {
  for (const fileOrDirName of (await fs.readdir(MY_XDG_CONFIG_HOME)).sort(sortAlpha)) {
    await symlink(
      path.join(MY_XDG_CONFIG_HOME, fileOrDirName),
      path.join(XDG_CONFIG_HOME, fileOrDirName),
    );
  }

  for (const fileOrDirName of (await fs.readdir(MY_HOME)).sort(sortAlpha)) {
    await symlink(path.join(MY_HOME, fileOrDirName), path.join(HOME, fileOrDirName));
  }

  function sortAlpha(a: string, b: string) {
    return a.localeCompare(b);
  }
}

async function symlink(targetPath: string, symlinkPath: string) {
  if (targetPath.endsWith(".ipython")) {
    // TODO: figure out how to handle .ipython like case
    try {
      await fs.mkdir(path.join(symlinkPath, "profile_default"), { recursive: true });
    } catch (err) {
      console.error("mkdir err", err);
      return;
    }
    targetPath = path.join(targetPath, "profile_default", "ipython_config.py");
    symlinkPath = path.join(symlinkPath, "profile_default", "ipython_config.py");
  }

  try {
    await fs.unlink(symlinkPath);
  } catch (err) {
    console.error("unlink err", err);
  }

  try {
    await fs.symlink(targetPath, symlinkPath);
    console.log(`symlink ${symlinkPath} -> ${targetPath}`);
  } catch (err) {
    console.error("symlink err", err);
  }
}

async function generateShellProfile() {
  const content = `
export DOTFILES_HOME="${DOTFILES_HOME}";
export ZDOTDIR="$DOTFILES_HOME/shell/zsh";
`;

  try {
    const filePath = path.join(HOME, ".zprofile");
    await fs.writeFile(filePath, content);
    console.log(`writeFile ${filePath}`);
  } catch (err) {
    console.error("writeFile err", err);
  }
}

async function installPackages(
  provider: string,
  packages: readonly string[],
  command: (packageName: string) => string,
) {
  console.log(`Installing ${provider} packages.`);

  await Promise.all(
    packages.map(async function installPackage(package_: string) {
      console.log(`Checking that "${package_}" exists.`);

      const { stdout, stderr } = await exec(command(package_));

      if (stdout) {
        console.log(stdout);
      }

      if (stderr) {
        console.log(stderr);
      }
    }),
  );
}
