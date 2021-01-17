defmodule ExIcalAttendeesOrganizersTest do
  use ExUnit.Case
  import ExIcal.Test.Utils

  test "attendees" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT:MAILTO:example1@mail.com
    ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT:MAILTO:example2@mail.com
    ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;CN=example3@mail.com:mailto:example3@mail.com
    UID:19960401T080045Z-4000F192713-0052@host1.com
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.attendees == ["example3@mail.com", "example2@mail.com", "example1@mail.com"]
  end

  test "organizer" do
    ical = """
    BEGIN:VCALENDAR
    CALSCALE:GREGORIAN
    VERSION:2.0
    BEGIN:VEVENT
    ORGANIZER;:mailto:example1@mail.com
    END:VEVENT
    END:VCALENDAR
    """
    events = ExIcal.parse(ical)

    assert events |> Enum.count == 1

    event = events |> List.first

    assert event.organizer == "example1@mail.com"
  end
end
