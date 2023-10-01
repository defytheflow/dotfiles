import * as os from "node:os";
import * as fs from "node:fs/promises";
import * as path from "node:path";

const HOME = os.homedir();
const XDG_CONFIG_HOME = process.env.XDG_CONFIG_HOME || path.join(HOME, ".config");

const MY_HOME = path.join(path.dirname(__dirname), "home");
const MY_XDG_CONFIG_HOME = path.join(path.dirname(__dirname), "xdg_config");

main();

async function main() {
  for (let fileOrDirName of (await fs.readdir(MY_XDG_CONFIG_HOME)).sort(sortAlpha)) {
    await symlink(
      path.join(MY_XDG_CONFIG_HOME, fileOrDirName),
      path.join(XDG_CONFIG_HOME, fileOrDirName)
    );
  }

  for (let fileOrDirName of (await fs.readdir(MY_HOME)).sort(sortAlpha)) {
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
