import matplotlib.pyplot as plt
from keras.models import load_model
from pkg_resources import resource_filename
from spliceai.utils import one_hot_encode
import numpy as np

paths = ('models/spliceai{}.h5'.format(x) for x in range(1, 6))
models = [load_model(resource_filename('spliceai', x)) for x in paths]

def get_probs(input_sequence):
  context = 10000
  x = one_hot_encode('N'*(context//2) + input_sequence + 'N'*(context//2))[None, :]
  y = np.mean([models[m].predict(x) for m in range(5)], axis=0)

  acceptor_prob = y[0, :, 1]
  donor_prob = y[0, :, 2]
  nt_pos = [a for a in range(len(acceptor_prob))]

  return acceptor_prob, donor_prob, nt_pos

def plot(nt_pos, acceptor_prob, donor_prob, trim_start=0, trim_end=0):
  # Create a new figure
  plt.figure()

  nt_pos = nt_pos[trim_start:len(nt_pos)-trim_end]
  donor_prob = donor_prob[trim_start:len(donor_prob)-trim_end]
  acceptor_prob = acceptor_prob[trim_start:len(acceptor_prob)-trim_end]

  # Plot the first time series trace
  plt.scatter(nt_pos, acceptor_prob, label='Acceptor')

  # Plot the second time series trace
  plt.scatter(nt_pos, donor_prob, label='Donor')

  # Add labels and legend
  plt.xlabel('Time')
  plt.ylabel('Value')
  plt.legend()

  # Limits
  plt.ylim(0,1)

  # Show the plot
  plt.show()