let panel = new Panel();
{
  panel.location = "bottom";
  panel.height = gridUnit * 2;
  panel.alignment = "center";
  panel.hiding = "autohide";
}

let kickoff = panel.addWidget("org.kde.plasma.kickoff");
{
  kickoff.icon = "start-here-symbolic";

  kickoff.currentConfigGroup = ["Shortcuts"];
  kickoff.writeConfig("global", "Alt+F1");
}

panel.addWidget("org.kde.plasma.icontasks");
panel.addWidget("org.kde.plasma.systemtray");
panel.addWidget("org.kde.plasma.digitalclock");
