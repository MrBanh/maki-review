-- maki-review entry point (default load path).
--
-- Managed installs via maki.pack.add use the custom loader in the user
-- config instead of this file; the loader calls require("review")
-- .setup(). This entry covers hand-installed copies
-- (site/pack/<group>/start/maki-review), which start with no options.
require("review").setup()
