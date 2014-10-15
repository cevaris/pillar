God.watch do |w|
  w.dir  = "/git/pillar/"
  w.name = "print-time"
  w.start = "bundle exec scripts/print-time"
  w.keepalive
end
