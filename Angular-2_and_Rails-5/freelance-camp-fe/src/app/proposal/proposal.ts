// variable names are snake case because we will later get them
// from rails api. and in rails snake case is standard

export class Proposal {
  constructor(
    public id?: number,
    public customer?: string,
    public portfolio_url: string = 'http://',
    public tools?: string,
    public estimated_hours?: number,
    public hourly_rate?: number,
    public weeks_to_complete?: number,
    public client_email?: string
  ){}
}

// sample record will look like:
// 15, 'Abc company', 'https://john.portfolio.com', 'Ruby on Rails',187,120,15,'john@mail.com'
