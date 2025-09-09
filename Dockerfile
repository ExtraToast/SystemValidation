FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:noble

# NOTE: This does not verify any signatures whatsoever. 
#       Use at your own risk and check the Dockerfile before you use it to make 
#       sure that you agree with it. 


# You might have to run 'why3 config detect' after starting the container
# if Frama-C cannot find the provers.

# Install basics
RUN apt-get update && apt-get -y install \
    curl \
    git

# ----------------------
# NuSMV
# ----------------------
ENV NUSMV_URL=https://nusmv.fbk.eu/distrib/NuSMV-2.6.0-linux64.tar.gz
RUN curl -fsSL "$NUSMV_URL" -o NuSMV_2_6_0.tar.gz 
RUN tar -xzf NuSMV_2_6_0.tar.gz
ENV PATH="$PATH:/NuSMV-2.6.0-Linux/bin"
RUN rm -r NuSMV_2_6_0.tar.gz

# ----------------------
# Larva
# ----------------------
# The implementation of Larva is provided in the 'given'-folder of the assignment
RUN apt-get -y install \
    openjdk-17-jdk \
    aspectj


# ----------------------
# CIVL
# ----------------------
ENV CIVL_URL=https://vsl.cis.udel.edu/lib/sw/civl/1.22/r5854/release/CIVL-1.22_5854.tgz
RUN apt-get -y install \
    cvc4 \
    z3
RUN curl -fsSL "$CIVL_URL" -o /opt/CIVL-1_22.tgz 
RUN tar -xzf /opt/CIVL-1_22.tgz -C /opt/
ENV PATH="$PATH:/opt/CIVL-1.22_5854/bin"
RUN rm -r /opt/CIVL-1_22.tgz


# ----------------------
# FramaC
# ----------------------
RUN apt -y install \
    opam \
    graphviz \
    libcairo2-dev \
    libgmp-dev \
    libgtk-3-dev \
    libgtksourceview-3.0-dev \
    pkg-config    
ENV OPAMROOT=/.opam
RUN opam -y init --compiler 4.14.1
RUN eval $(opam env)
RUN opam -y install frama-c

CMD ["sleep", "infinity"]