/** @type {import("prettier").Options} */
module.exports = {
  printWidth: 90,
  arrowParens: "avoid",
  overrides: [
    {
      files: "settings.json",
      options: {
        printWidth: 100,
      },
    },
  ],
};
