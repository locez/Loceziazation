return {
  -- 告诉 LazyVim 去 GitHub 拉取 Gentoo 官方维护的语法高亮插件
  "gentoo/gentoo-syntax",
  -- 可选优化：只有当你打开这些特定文件时，才“懒加载”这个插件，节省启动时间
  ft = { "ebuild", "eclass" },
  event = { "BufReadPre", "BufNewFile" }
}
