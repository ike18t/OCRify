FROM tesseractshadow/tesseract4re

RUN apt-get install -y vim

COPY convert.sh /bin/convert
RUN chmod +x /bin/convert

COPY crontab /etc/cron.d/ocrify
RUN chmod 0644 /etc/cron.d/ocrify
# Apply cron job
RUN crontab /etc/cron.d/ocrify
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
