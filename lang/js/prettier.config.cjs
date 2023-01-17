/** @type {import("prettier").Options} */
module.exports = {
  printWidth: 90,
  arrowParens: "avoid",
  plugins: [require.resolve("prettier-plugin-tailwindcss")],
};
