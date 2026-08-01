FROM accetto/ubuntu-vnc-xfce-g3:latest
USER root
ENV PORT=10000
ENV NO_VNC_PORT=${PORT}
EXPOSE ${PORT}
WORKDIR ${STARTUPDIR}
ENTRYPOINT ["./vnc_startup.sh"]
CMD [ "--wait" ]
