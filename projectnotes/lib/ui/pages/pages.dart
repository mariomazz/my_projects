enum Pages { home, login, note }

extension ExtPages on Pages {
  get route => "/$name";
}
