import { FreelanceCampFePage } from './app.po';

describe('freelance-camp-fe App', () => {
  let page: FreelanceCampFePage;

  beforeEach(() => {
    page = new FreelanceCampFePage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!!');
  });
});
