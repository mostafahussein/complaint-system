module Modules
  module Charts
    def yearly_chart
      total_tickets = Ticket.total_timeline
      total_tickets = total_tickets.collect {|k,v| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/total_tickets.json','w') do |f|
        f.write(JSON.pretty_generate(total_tickets))
      end
    end

    def tickets_with_statuses
      open_status = Ticket.open_timeline
      open_status = open_status.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/open_status.json','w') do |f|
        f.write(JSON.pretty_generate(open_status))
      end

      in_progress_status = Ticket.in_progress_timeline
      in_progress_status = in_progress_status.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/in_progress_status.json','w') do |f|
        f.write(JSON.pretty_generate(in_progress_status))
      end

      pending_status = Ticket.pending_timeline
      pending_status = pending_status.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/pending_status.json','w') do |f|
        f.write(JSON.pretty_generate(pending_status))
      end

      solved_status = Ticket.solved_timeline
      solved_status = solved_status.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/solved_status.json','w') do |f|
        f.write(JSON.pretty_generate(solved_status))
      end

      closed_status = Ticket.closed_timeline
      closed_status = closed_status.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/closed_status.json','w') do |f|
        f.write(JSON.pretty_generate(closed_status))
      end

    end

    def tickets_with_priorities
      high_tickets = Ticket.high_timeline
      high_tickets = high_tickets.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/high_tickets.json','w') do |f|
        f.write(JSON.pretty_generate(high_tickets))
      end

      normal_tickets = Ticket.normal_timeline
      normal_tickets = normal_tickets.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/normal_tickets.json','w') do |f|
        f.write(JSON.pretty_generate(normal_tickets))
      end

      low_tickets = Ticket.low_timeline
      low_tickets = low_tickets.collect {|k| [k['date'].to_i,k['count'].to_i]}
      File.open('./app/views/tickets/low_tickets.json','w') do |f|
        f.write(JSON.pretty_generate(low_tickets))
      end

    end

    def advisors_statistics
      @advisors_complaints = TicketStatus.advisor_status_details
    end
    
    def staff_statistics
      @staff_complaints = TicketStatus.staff_status_details
    end

    def complaints_statistics
      @complaint_status_details = TicketStatus.ticket_status_details

      @complaint_priority_details = Ticket.ticket_priority_details
    end

    def subjects_statistics
      @subjects_details = Ticket.subject_priority_details
    end
    
    def start_end
      @min = (Date.today.beginning_of_month).to_datetime.to_i*1000
      @max = (Date.today.at_end_of_month).to_datetime.to_i*1000
    end
    
    def mini_charts
      @recent_tickets = Ticket.recent
      @today_tickets = Ticket.today
      @upcoming_tickets = Ticket.upcoming
      @overdue_tickets = Ticket.overdue
    end
  end
end